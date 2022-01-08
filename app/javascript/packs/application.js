// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'stylesheets/application.scss'
import 'external/vanillaSelectBox.js'
import 'external/clipboard.min.js'

import Rails from 'mrujs'
import * as Turbo from '@hotwired/turbo'
import * as ActiveStorage from '@rails/activestorage'
// import 'external/sortable.min.js'
// import 'stylesheets/sortable.min.css'

// import dt from "datatables.net";

// document.addEventListener("turbolinks:load", () => {
//     dt(window, $);
// });

// var loadNextPage = function(){
//     if ($('#next_link').data("loading")){ return }  // prevent multiple loading
//     var wBottom  = $(window).scrollTop() + $(window).height();
//     var elBottom = $('#records_table').offset().top + $('#records_table').height();
//     if (wBottom > elBottom){
//       $('#next_link')[0].click();
//       $('#next_link').data("loading", true);
//     }
//   };
  
//   window.addEventListener('resize', loadNextPage);
//   window.addEventListener('scroll', loadNextPage);
//   window.addEventListener('load',   loadNextPage);
  


import 'controllers'
import 'channels'

window.Turbo = Turbo

Rails.start()
ActiveStorage.start()
