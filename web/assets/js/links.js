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

(function(){

    var template = document.querySelector("#navbar-burger")
    get_links().forEach(function(e, i){
        console.log(e)
    })
})()