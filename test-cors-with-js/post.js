var data = "{\n    \"hello\": \"Hola\"\n}";

var xhr = new XMLHttpRequest();
// xhr.withCredentials = true;

xhr.addEventListener("readystatechange", function() {
  if(this.readyState === 4) {
    console.log(this.responseText);
  }
});

xhr.open("POST", "https://rpbwxg7zhd.execute-api.us-east-1.amazonaws.com/dev/post-hello");
xhr.setRequestHeader("Content-Type", "text/plain");

xhr.send(data);