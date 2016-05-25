var PR = PR || {};

PR = (function(window, document, Prismatic){
  Prismatic.util = {
    getSessionId : function(){
      return store("prismatic_id") || Prismatic.util.generateUUID();
    },
    //generate UUID
    generateUUID : function(){
      var d = new Date().getTime();
      var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
      });
      return uuid;
    },

    pageDefaults: function() {
      return {
        path: Prismatic.util.canonicalPath(),
        referrer: document.referrer,
        search: location.search,
        title: document.title,
        url: Prismatic.util.canonicalUrl(location.search)
      };
    },
    canonicalPath: function() {
      var canon = Prismatic.util.canonical();
      if (!canon) return window.location.pathname;
      var parsed = url.parse(canon);
      return parsed.pathname;
    },  
    canonical: function() {
      var tags = document.getElementsByTagName('link');
      // eslint-disable-next-line no-cond-assign
      for (var i = 0, tag; tag = tags[i]; i++) {
        if (tag.getAttribute('rel') === 'canonical') {
          return tag.getAttribute('href');
        }
      }
    },
    canonicalUrl: function(search) {
      var canon = Prismatic.util.canonical();
      if (canon) return includes('?', canon) ? canon : canon + search;
      var url = window.location.href;
      var i = url.indexOf('#');
      return i === -1 ? url : url.slice(0, i);
    },
    browserInfo : function(){
      return {
        user_agent: navigator.userAgent,
        locale:  navigator.language || navigator.browserLanguage || navigator.systemLanguage || navigator.userLanguage
      }
    }  
  };

  return Prismatic;
})(this, this.document, PR);

