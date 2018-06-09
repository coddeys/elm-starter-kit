const { Elm } = require("./Main.elm");

Elm.Main.init({
    flags: "string",
    node: document.querySelector("main")
});
