const express = require('express')
const router = express.Router();
const postlogin = require('../Controller/auth_login');

router
    .post('/postregister', postlogin.postregister)
    // .post('/postlogin', postlogin.postlogin)
    
module.exports = router;