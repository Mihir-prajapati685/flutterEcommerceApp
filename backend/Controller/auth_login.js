const mongoose = require('mongoose');
const authschemamodle = require('../Modles/Schema');

exports.postregister = async (req, res) => {
    try {
        const { email, password,username} = req.body;
       console.log(req.body);
        if (!email || !password || !username) {
            return res.status(400).json({ sucess: false, message: 'email and password not found' });
        }
        const dataread = await authschemamodle.findOne({ email });
        if (dataread) {
            return res.status(400).json({ message: 'data already found', sucess: false });
        }
        const createdata = await authschemamodle.create({ username, email, password });
        if (createdata) {
            return res.status(201).json({ message: 'create user succesfully', sucess: true });
        }
        
    } catch (err) {
        return res.status(500).json({ message: 'server problem', sucess: false });
    }  
}
// exports.postlogin = async (req, res) => {
    
// }