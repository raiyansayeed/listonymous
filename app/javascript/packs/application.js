// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'stylesheets/application.scss'

import Rails from 'mrujs'
import * as Turbo from '@hotwired/turbo'
import * as ActiveStorage from '@rails/activestorage'
import 'external/sortable.min.js'
import 'stylesheets/sortable.min.css'



import 'controllers'
import 'channels'

window.Turbo = Turbo

Rails.start()
ActiveStorage.start()

import "controllers"
