var express = require('express');
var router = express.Router();
var { db } = require('../db');

// 获取药品清单
router.get('/', function (req, res) {
    db.query('SELECT * FROM medicine', function (err, result) {
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
    });
})

// 新增
router.post('/add', function (req, res) {
    const medicine = req.body
    const inserSql = `INSERT INTO medicine SET ?`
    const data = { serial_id: medicine.serial_id, name: medicine.name, picture: medicine.picture, desc: medicine.desc }
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

// 删除
router.post('/delete', function (req, res, next) {
    const id = req.query.id
    const deleteSql = `DELETE FROM medicine WHERE serial_id = ?`
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