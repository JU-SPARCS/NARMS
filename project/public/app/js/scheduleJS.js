(function ($) {
    $(onDomReady());
function onDomReady() {
        console.log('ready');
    }
    $(".send").on('click', function (e) {
        console.log("lancer la request");
        var param = { "ResponseURL": "http://toto.fr",
                  "Events": [
                    {
                      "TimeZone": "Europe/Paris",
                      "StartTime": "2016-02-05 17:18:30",
                      "EndTime": "2016-02-06 17:18:30",
                      "ASMEnvironment": "T",
                      "ControlTechnology": "R",
                      "ControllerStatus": "MCS",
                      "Traffic": "VL",
                      "Equipment": "O",
                      "Weather": "HD"
                    },
                    {
                      "TimeZone": "Europe/Paris",
                      "StartTime": "2016-02-05 17:18:30",
                      "EndTime": "2016-02-06 17:18:30",
                      "ASMEnvironment": "T",
                      "ControlTechnology": "R",
                      "ControllerStatus": "MCS",
                      "Traffic": "H",
                      "Equipment": "O",
                      "Weather": "HD"
                    }
                  ]
                };
        $.ajax({
            type: "POST",
            url: "http://193.10.30.123/evaluations",
            beforeSend: function (request)
            {
                request.setRequestHeader("Authority", "NEtKcVJ4VUtRUXd1S1BiTQ==");
            },
             data: {"Content-Type": param},
             dataType: 'json',
             success: function(data){
                alert('Request send to SAFAPS');
            }
            
            });
    });


})(jQuery);
