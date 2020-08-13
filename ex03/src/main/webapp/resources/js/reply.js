console.log("Reply Module...");

var replyService = (function (){
    
    function add(reply, callback, error){
        console.log("add reply......");

        $.ajax({
          type : 'post',
          url : contextPath + '/replies/new',
          data : JSON.stringify(reply),
          contentType : "application/json; charset=utf-8",
          success : function(result, status, xhr){
              if(callback){
                  callback(result);
              }
          },
          error : function(xhr, status, er){
              if (error){
                  error(er);
              }
          }
        })
    }

    function getList(param, callback, error){
        var bno = param.bno;
        var page = param.page || 1;

        $.getJSON(contextPath+"/replies/pages/" + bno + "/" +page + ".json",
            function(data){
                if(callback){
                    //callback(data);
                    callback(data.replyCnt, data.list);
                }
            }).fail(
            function(xhr, status, err){
                if(error){
                    error();
                }
            });      
    }

    function remove(rno, callback, error){
        $.ajax({
            type : "delete",
            url : contextPath + '/replies/' + rno,
            success : function(deleteResult, status, xhr){
                if(callback){
                    callback(deleteResult);
                }
            },
            error : function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        });
    }

    function update(reply, callback, error){
        console.log("RNO: " + reply.rno);
        $.ajax({
            type : 'put',
            url : contextPath + '/replies/' + reply.rno,
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            error : function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        })
    }

    function get(rno, callback, error){
        $.get(contextPath + "/replies/" + rno + ".json", function(result){
            if(callback){
                callback(result);
            }
        }).fail(function(xhr, status, err){
            if(error){
                error();
            }
        });
    }

    function displayTime(timeValue){
        var today = new Date();
        
        var isSameDay =
         (today.getFullYear == today.getFullYear(timeValue))&&
         (today.getMonth == today.getMonth(timeValue))&&
         (today.getDay == today.getMonth(timeValue));

        var dateObj = new Date(timeValue);
        var str = "";

        if(isSameDay){
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            return [(hh>9 ? '' : '0') + hh, ':', (mi>9 ? '' : '0') + mi,
                ':',(ss>9 ? '' : '0') + ss].join('');
        } else {
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth() + 1; 
            var dd = dateObj.getDate();

            return [ yy, '/', (mm>9?'':'0')+mm, '/', (dd>9?'':'0')+dd].join('');

        }
    }
    return {
            add:add,
            getList : getList,
            remove : remove,
            update : update,
            get : get,
            displayTime : displayTime
    };
})();


 

 

    