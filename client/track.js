function Track(url,name,properties,contextInfo) {
  this.url = url;
  this.name = name;
  this.properties = properties;
  this.contextInfo = contextInfo;
}
Track.prototype = {
  
  send: function(){
    jsonData = {
      event_name: this.name,
      properties: this.properties,
      context_info: this.contextInfo.context,
      browser: this.contextInfo.browser,
      session_id: this.contextInfo.session_id,
      user_id: this.contextInfo.user_id,
      trackerName: this.contextInfo.trackerName,
      trackTime: new Date().toUTCString()

    }
    this.sendAjaxRequest(this.url,jsonData)
  },
  sendAjaxRequest : function(url, obj, headers, fn){
    console.log(obj)
    headers = { 'Content-Type': 'text/plain' };
      var req = new XMLHttpRequest;
      req.onerror = trackError;
      req.onreadystatechange = done;
      req.open('POST', url, true);
      for (var k in headers) req.setRequestHeader(k, headers[k]);
      console.log(obj)   
      req.send(JSON.stringify(obj));
      function trackError(){
        // console.log(req.status)
      }
      function done(){
        // console.log(req.status)
        // if (4 == req.readyState) return fn(null, req);
      }

  }
  

}
