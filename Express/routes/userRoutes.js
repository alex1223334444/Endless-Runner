const express = require('express')
const router = express.Router()
const Task = require('../models/task')
const User = require('../models/user')

router.get('/', (req, res) => {
    User.find()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.get('/create', (req, res) => {
    const user = new User({
        firstName : 'Taticu',
        lastName : 'Taticu',
        username : 'taticu',
        uid : '1'
    })

    user.save()
    .then((results) => {
        res.send(results)
    })
    .catch((err)=>{
        console.log(err)
    })
})

router.get('/user/:id', (req, res) => {
    User.find({
        uid : req.params.id
    })
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

module.exports = router