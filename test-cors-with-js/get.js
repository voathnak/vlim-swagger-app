var xhr = new XMLHttpRequest();
// xhr.withCredentials = true;

xhr.addEventListener("readystatechange", function() {
  if(this.readyState === 4) {
    console.log(this.responseText);
  }
});

xhr.open("GET", "https://rpbwxg7zhd.execute-api.us-east-1.amazonaws.com/dev/hello");

xhr.send();