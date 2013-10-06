express = require 'express'

app = express()

app.configure ->
  app.use '/admin', express.static "#{__dirname}/adminUI/public"

app.listen 1337
