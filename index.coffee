command: "curl -sS 'http://rss.weather.gov.hk/rss/CurrentWeather.xml' | sed -n '29,44p;' | egrep '(a.m.)|(p.m.)|(img src)| (degrees Celsius)|(per cent)|(Standby Signal, No. 1)|(Strong Wind Signal, No. 3)|(No. 8 Northeast Gale or Storm Signal)|(No. 8 Northwest Gale or Storm Signal)|(No. 8 Southeast Gale or Storm Signal)|(No. 8 Southwest Gale or Storm Signal)|(Increasing Gale or Storm Signal, No. 9)|(Hurricane Signal, No. 10)|(Amber Rainstorm Warning Signal)|(Red Rainstorm Warning Signal)|(Black Rainstorm Warning Signal)|(Thunderstorm Warning)|(Special Announcement On Flooding In Northern New Territories)|(Landslip Warning)|(Strong Monsoon Signal)|(Frost Warning)|(Yellow Fire Danger Warning)|(Red Fire Danger Warning)|(Cold Weather Warning)|(Very Hot Weather Warning)|(Tsunami Warning)'"

refreshFrequency: 120000

render: -> """
  <div class="container">
    <table class="stats-container" width="100%">
      <tr>
        <td>
            
        </td>
      </tr>
      <tr>
        <td>
            <img class="imgicon" src=""></span><span class="warn"></span>
            <span class="celsius"></span>°C
            <span class="percent"></span>%
            <span class="lastupdated"></span>
        </td>
      </tr>
    </table>
  </div>
"""


update: (output, domEl) ->
    if(output != null)
        domain = "http://rss.weather.gov.hk/"
        cel = output.match(/([0-9-]+) degrees Celsius/)
        percent = output.match(/([0-9-]+) per cent/)
        image = output.match(/pic([0-9-]+).png/)
        lastupdated = output.match(/([\s\S]{2} p.m.|[\s\S]{2} a.m.)/)

        warning = output.match(/(Standby Signal, No. 1)|(Strong Wind Signal, No. 3)|(No. 8 Northeast Gale or Storm Signal)|(No. 8 Northwest Gale or Storm Signal)|(No. 8 Southeast Gale or Storm Signal)|(No. 8 Southwest Gale or Storm Signal)|(Increasing Gale or Storm Signal, No. 9)|(Hurricane Signal, No. 10)|(Amber Rainstorm Warning Signal)|(Red Rainstorm Warning Signal)|(Black Rainstorm Warning Signal)|(Thunderstorm Warning)|(Special Announcement On Flooding In Northern New Territories)|(Landslip Warning)|(Strong Monsoon Signal)|(Frost Warning)|(Yellow Fire Danger Warning)|(Red Fire Danger Warning)|(Cold Weather Warning)|(Very Hot Weather Warning)|(Tsunami Warning)/g)
        
        $(domEl).find(".celsius").text cel[1]
        $(domEl).find(".percent").text percent[1]
        $(domEl).find(".imgicon").attr("src",  domain + "/img/pic" + image[1] + ".png")
        if (lastupdated != null)
          $(domEl).find(".lastupdated").text "Hong Kong " + lastupdated[1]
        if (warning != null)
          $(domEl).find(".warn").html ""
          for warn, i in warning
            $(domEl).find(".warn").append "&nbsp;<img src=\"" + domain + "img/" + @iconWarning[warning[i]] + "\" \\>"

 

style: """
  bottom: 10px
  left: 30px
  margin: 0px
  font-family: Helvetica Neue
  font-size: 4em
  font-weight:100
  color: #fff

  .lastupdated
    font-size: 0.3em
  .warn
    font-size: 0.2em

    

"""

    
iconWarning:
  "Standby Signal, No. 1" : "tc1.gif"
  "Strong Wind Signal, No. 3" : "tc3.gif"
  "No. 8 Northeast Gale or Storm Signal" : "tc8ne.gif"
  "No. 8 Northwest Gale or Storm Signal" : "tc8nw.gif"
  "No. 8 Southeast Gale or Storm Signal" : "tc8se.gif"
  "No. 8 Southwest Gale or Storm Signal" : "tc8sw.gif"
  "Increasing Gale or Storm Signal, No. 9" : "tc9.gif"
  "Hurricane Signal, No. 10"  : "tc10.gif"
  "Amber Rainstorm Warning Signal" : "raina.gif"
  "Red Rainstorm Warning Signal" : "rainr.gif"
  "Black Rainstorm Warning Signal"  : "rainb.gif"
  "Thunderstorm Warning" : "ts.gif"
  "Special Announcement On Flooding In Northern New Territories" : "ntfl.gif" 
  "Landslip Warning" : "landslip.gif"
  "Strong Monsoon Signal"  : "sms.gif"
  "Frost Warning" : "frost.gif"
  "Yellow Fire Danger Warning"  : "firey.gif"
  "Red Fire Danger Warning"  : "firer.gif"
  "Cold Weather Warning"  : "cold.gif"
  "Very Hot Weather Warning" : "vhot.gif" 
  "Tsunami Warning" : "tsunami-warn.gif"



