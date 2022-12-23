const express = require('express')
const morgan = require('morgan')
const mongoose = require('mongoose')
const Task = require('./models/task')
const User = require('./models/user')
const app = express()
const userRoutes = require('./routes/userRoutes')

const dbURL = 'mongodb+srv://userTBD:ikEgsDiZCxkvzclY@users.0sv7cig.mongodb.net/Users'
mongoose.connect(dbURL, { useNewUrlParser: true })
.then((result) =>{ 
    app.listen(3000)
    console.log('connected to db')
})
.catch((err) => console.log(err))


app.use(morgan('dev'))
app.use('/users',userRoutes)

app.get('/', (req, res) => {

    res.send('hello to the backend')

})

