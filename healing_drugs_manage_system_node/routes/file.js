var express = require('express');
var router = express.Router();
var multer = require('multer')
var fs = require('fs')
const path = require('path');

const downloadUrl = 'http://localhost:3000/file/download/'
// const mime = require("mime");
// 定义文件上传的配置
const upload = multer({
    storage: multer.diskStorage({
        destination: './public/images',
        filename: (req, file, cb) => {
            // 获取文件的后缀名
            const fileExtname = path.extname(file.originalname);
            const newFileName = `${Date.now()}${fileExtname}`;
            cb(null, newFileName);
        },
    }),
});

// 上传单个文件
router.post('/upload', upload.single('file'), (req, res) => {
    // 获取文件名
    const fileName = req.file.filename;
    res.send({
        code: 200,
        msg: '上传成功',
        data: downloadUrl + fileName
    })
})

// 文件下载接口
router.get('/download/:fileName', function (req, res) {
    // 获取文件名
    const fileName = req.params.fileName;
    // 读取文件
    const file = fs.readFileSync(`./public/images/${fileName}`);

    // 设置响应头
    // res.setHeader("Content-Disposition", `attachment; filename=${fileName}`);
    // res.setHeader("Content-Type", mime.lookup(fileName));

    // 返回文件流
    res.send(file);
})

module.exports = router;