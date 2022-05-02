require("dotenv").config();
const { Pool } = require("pg");
var fs = require('fs');

const database = process.env.PGDATABASE;

const connectionString = `postgresql://${process.env.PGUSER}:${process.env.PGPASSWORD}@${process.env.PGHOST}:${process.env.PGPORT}/${database}`;

const pool = new Pool({
   connectionString  
});



// const users = fs.readFileSync(('./config/init.sql')).toString();

// pool.query(users,  (err, result) => {
//     if (err){
//           throw err;
//     }else{
//         console.log(done);
//     }

// });


module.exports = {
  query: (text, params) => pool.query(text, params),
  end: () => pool.end(),
};
