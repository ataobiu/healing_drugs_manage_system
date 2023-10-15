var express = require('express');
var router = express.Router();
var { db } = require('../db');
const moment = require('moment');

// 获取系统公告
router.get('/annunciate', function (req, res, next) {
    db.query('SELECT * FROM sys', function (err, result) {
        if (err) {
            console.log(err);
            return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
        } else {
            for (var i = 0; i < result.length; i++) {
                result[i].create_time = moment(result[i].create_time).format('YYYY-MM-DD HH:mm:ss');
            }
            res.send({
                code: 200,
                message: '请求成功！',
                data: result
            })
        }
    })
})

// 新增系统公告
router.post('/add', function (req, res, next) {
    const newSys = req.body
    const inserSql = `INSERT INTO sys SET ?`
    const data = { content: newSys.content, create_time: moment(new Date()).format("YYYY-MM-DD HH:DD:MM") }
    db.query(inserSql, data, function (err, result) {
        if (err) {
            console.log(err);
            return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
        } else {
            res.send({
                code: 200,
                message: '请求成功！',
                data: result
            })
        }
    })
})

// 删除系统公告
router.post('/delete', function (req, res, next) {
    const id = req.query.id
    const deleteSql = `DELETE FROM sys WHERE id = ?`
    db.query(deleteSql, id, function (err, result) {
        if (err) {
            console.log(err);
            return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
        } else {
            res.send({
                code: 200,
                message: '请求成功！',
            })
        }
    })
})

module.exports = router;