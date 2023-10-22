function get_links(){
    return [
        {
            name: "Batman",
            path: "toto/toto",
            link: "https://tralala.com/dl/monliengjqhkwfgvnlqifkgjvnmjqedskfgjvnqjmdkgvkqdfgerhgilq",
            expiration : 1539023048
        },
        {
            name: "La ligne verte",
            path: "toto/toto",
            link: "https://tralala.com/dl/monliengjqhkwfgvnlqifkgjvnmjqedskfgjvnqjmdkgvkqdfgerhgilq",
            expiration : 1539023048
        },
        {
            name: "Les infiltrés",
            path: "toto/toto",
            link: "https://tralala.com/dl/monliengjqhkwfgvnlqifkgjvnmjqedskfgjvnqjmdkgvkqdfgerhgilq",
            expiration : 1539023048
        },
        {
            name: "Pretty woman",
            path: "toto/toto",
            link: "https://tralala.com/dl/monliengjqhkwfgvnlqifkgjvnmjqedskfgjvnqjmdkgvkqdfgerhgilq",
            expiration : 1539023048
        }
    ]
}

function string_preview(s) {
    if (s.length < 60){
        return s
    }else{
        return s.slice(20) + "..." + s.slice(-37)
    }
}

function timeConverter(UNIX_timestamp){
  var a = new Date(UNIX_timestamp * 1000);
  var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  var year = a.getFullYear();
  var month = months[a.getMonth()];
  var date = a.getDate();
  var hour = a.getHours();
  var min = a.getMinutes();
  var sec = a.getSeconds();
  var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
  return time;
}

function sliceIntoChunks(arr, chunkSize) {
    const res = [];
    for (let i = 0; i < arr.length; i += chunkSize) {
        const chunk = arr.slice(i, i + chunkSize);
        res.push(chunk);
    }
    return res;
}

const numb_col = 2;

(function(){
    "use strict"; // Start of use strict
    var template = document.querySelector(".link-card")
    console.log(template)
    var cards = get_links().map(function(e, i){
        var new_elem = template.cloneNode(true)
        new_elem.querySelector('.card-title').innerHTML = e.name
        new_elem.querySelector('.file').innerHTML = string_preview(e.path)
        new_elem.querySelector('.url').innerHTML = string_preview(e.link)
        new_elem.querySelector('.expiration').innerHTML = timeConverter(e.expiration)
        return new_elem
    })
    document.querySelector(".template-to-delete").remove()
    sliceIntoChunks(cards, numb_col).forEach(function(r, i) {
        var row = document.createElement("div")
        row.className = "row"
        r.forEach(function(c, i) {
            row.appendChild(c)
        })
        document.querySelector(".links-container").appendChild(row);
    })
})()