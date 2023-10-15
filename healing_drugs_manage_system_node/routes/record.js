var express = require('express');
var router = express.Router();
var { db } = require('../db');
const moment = require('moment');

// 获取记录
router.get('/', function (req, res) {
    db.query('SELECT * FROM record', function (err, result) {
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
    const record = req.body
    const inserSql = `INSERT INTO record SET ?`
    const data = { serial_id: record.serial_id, import: record.import, export: record.export, date: moment(record.date).format("YYYY-MM-DD HH:DD:MM") }
    console.log(data);
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
router.post('/delete', function (req, res) {
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

// 统计图数据
router.get('/tjs', function (req, res) {
    // 统计前三天进出口数据
    const sql = `SELECT
                    DATE_FORMAT(date, '%Y-%m-%d') AS date,
                    SUM(import) AS import,
                    SUM(export) AS export
                FROM record
                WHERE
                    date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 3 DAY)
                    AND CURRENT_DATE()
                GROUP BY
                    DATE_FORMAT(date, '%Y-%m-%d')
                ORDER BY date DESC`
    db.query(sql, function (err, result) {
        if (err) {
            console.log(err);
            return res.send({
                code: 400,
                msg: "Internal Server Error"
            })
        } else {
            const data = result.map((item) => ({
                date: item.date,
                '进口': item.import,
                '出口': item.export,
            }));
            res.send({
                code: 200,
                message: '请求成功！',
                data: data
            })
        }
    })
})

module.exports = router;