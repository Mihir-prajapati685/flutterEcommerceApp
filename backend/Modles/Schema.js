const mongoose = require('mongoose');

const authschema = new mongoose.Schema({
    Username: {
        type: String,
    },
    email: {
        type: String,
        required:true
    },
    password: {
        type: String,
        required:true
    },
});

const authschemamodle = mongoose.model('flutter_schema', authschema);
module.exports = authschemamodle;