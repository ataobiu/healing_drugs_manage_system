// drivingSchool
const mysql = require('mysql2')

const db = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '..123',
    database: 'healing_drugs_manage_system',
})
const secret = "dayhadty737hth453rth5753254fgf345"
module.exports = { db, secret };