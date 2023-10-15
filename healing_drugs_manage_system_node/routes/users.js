var express = require('express');
var router = express.Router();
var { db, secret } = require('../db');
const jwt = require('jsonwebtoken')
const moment = require('moment');

// 登录接口
router.post('/login', function (req, res, next) {
    const userinfo = req.body
    const sqlStr = `SELECT * FROM users where user = ?`
    db.query(sqlStr, userinfo.user, function (err, results) {
        // 执行 SQL 语句失败
        if (err) return res.send({
            code: 400,
            msg: "Internal Server Error"
        })
        // 执行 SQL 语句成功，但是查询到数据条数不等于 1
        if (results.length !== 1 || userinfo.password !== results[0].password) return res.send({
            code: 400,
            msg: '用户名或密码错误，请重新输入！'
        })
        const data = { ...results[0], password: '' }
        // 将时间格式转换为 "YYYY-MM-DD HH:DD:MM"
        data.create_time = moment(data.create_time).format('YYYY-MM-DD HH:mm:ss');
        data.last_time = moment(data.last_time).format('YYYY-MM-DD HH:mm:ss');
        // 生成 Token 字符串
        const token = jwt.sign(data, secret, {
            expiresIn: '10h', // token 有效期为 10 个小时
        })
        res.send({
            code: 200,
            message: '登录成功！',
            data: {
                data: data,
                token: 'Bearer ' + token
            }
        })
        const updateSql = `UPDATE users SET last_time = ? WHERE user = ?`
        db.query(updateSql, [moment(new Date()).format("YYYY-MM-DD HH:DD:MM"), userinfo.user], function (err, results) {
            // 执行 SQL 语句失败
            if (err) return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
        })
    })
});
// 注册接口
router.post('/register', function (req, res, next) {
    const userinfo = req.body

    // 定义sql语句
    const sqlStr = `SELECT * FROM users WHERE user = ?`
    // 执行 SQL 语句并根据结果判断用户名是否被占用
    db.query(sqlStr, [userinfo.user], (err, results) => {
        // 执行sql语句失败
        if (err) {
            return res.send({
                code: 400,
                msg: "Internal Server Error"
            });
        }
        // 判断用户名是否被占用
        if (results.length > 0) {
            return res.send({ code: 400, msg: '用户名被占用，请更换其他用户名！' })
        }
        const sqlStr = `INSERT INTO users SET ?`
        // 要插入的新数据
        const data = { user: userinfo.user, password: userinfo.password, create_time: moment(new Date()).format("YYYY-MM-DD HH:DD:MM") };
        db.query(sqlStr, data, function (err) {
            // 执行 SQL 语句失败
            if (err) return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
            res.send({
                code: 200,
                message: '注册成功！'
            })
        })
    });
})
//修改用户
router.post('/update', function (req, res) {
    const userinfo = req.body
    const id = req.query.id
    let sqlStr = ''
    let params = []
    if (userinfo.name) {
        sqlStr += 'name = ? '
        params.push(userinfo.name)
    }
    if (userinfo.password) {
        sqlStr += 'password = ? '
        params.push(userinfo.password)
    }
    if (userinfo.avatar) {
        sqlStr += 'avatar = ? '
        params.push(userinfo.avatar)
    }
    sqlStr += 'where id = ?'
    params.push(id)
    const finalSqlStr = `UPDATE users SET ${sqlStr}`
    db.query(finalSqlStr, params, function (err) {
        // 执行 SQL 语句失败
        if (err) {
            console.log(err)
            return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
        }
        db.query('select * from users where id = ?', [id], function (err, results) {
            const data = { ...results[0], password: '' }
            // 将时间格式转换为 "YYYY-MM-DD HH:DD:MM"
            data.create_time = moment(data.create_time).format('YYYY-MM-DD HH:mm:ss');
            data.last_time = moment(data.last_time).format('YYYY-MM-DD HH:mm:ss');
            // 生成新的 Token 字符串
            const token = jwt.sign(data, secret, {
                expiresIn: '10h', // token 有效期为 10 个小时
            })
            res.send({
                code: 200,
                msg: "修改成功！",
                data: {
                    data: data,
                    token: 'Bearer ' + token
                }
            })
        })
    })
})

module.exports = router;
