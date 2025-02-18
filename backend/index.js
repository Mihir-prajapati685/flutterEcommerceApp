const express = require('express');
const mongoose = require('mongoose');
const router=require('./Router/routes');
const cors=require('cors');
const server = express();

server.use(express.json());
server.use(cors());
server.use(express.urlencoded({extended:true}));

mongoose.connect('mongodb://localhost:27017/flutterDatabse').then(() => {
    console.log('mongoose connect sucessfully');
    
}).catch((err) => {
    console.log('mongoose not connect', err);
})
server.use('/', router);

server.listen(8000, () => {
    console.log('server connect');
});
