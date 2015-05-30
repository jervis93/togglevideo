import urllib2
import re
import json

# set to 1 for debugging
debug = 0

url = "http://video.toggle.sg/en/series/118-catch-up/ep126/328542"

# sample (m3u8 and mp4) links
#url = "http://video.toggle.sg/en/series/sabo/ep4/326841"

# sample wvm link
#url = "http://video.toggle.sg/en/series/marvel-s-agents-of-s-h-i-e-l-d-yr-2/ep6/327671"

print "\n[i] Given Toggle URL = %s" % (url)
urlsplit = url.split('/')
mediaID = urlsplit[-1]
if (debug):
	print "[*] Obtained mediaID = %s" % (mediaID)
print "[i] Performing HTTP GET request on Toggle URL ..."
urlresp = urllib2.urlopen(url).read()

if (debug):
	text_file = open("1.urlresp.txt", "w")
	text_file.write("{}".format(urlresp))
	text_file.close()

mwembedIndex = urlresp.find("mwEmbed",3500)
mwembedStr = urlresp[(mwembedIndex-70):(mwembedIndex+60)]
mwembedValue = re.split('//|">',mwembedStr)[1]
mwembedValue = "http://"+mwembedValue
if (debug):
	print "[*] Obtained mwembed URL = %s" % (mwembedValue)

apiUserIndex = urlresp.find("apiUser",40000)
apiUserStr = urlresp[apiUserIndex:(apiUserIndex+30)]
apiUserValue = re.split('"',apiUserStr)[1]
if (debug):
	print "[*] Obtained apiUser = %s" % (apiUserValue)

apiPassIndex = urlresp.find("apiPass",40000)
apiPassStr = urlresp[apiPassIndex:(apiPassIndex+30)]
apiPassValue = re.split('"',apiPassStr)[1]
if (debug):
	print "[*] Obtained apiPass = %s" % (apiPassValue)

print "[i] Performing HTTP GET request on mwembed URL ..."
mwembedresp = urllib2.urlopen(mwembedValue).read()

if (debug):
	text_file = open("2.mwembedresp.txt", "w")
	text_file.write("{}".format(mwembedresp))
	text_file.close()

scriptloaderIndex = mwembedresp.find("SCRIPT_LOADER_URL",100)
scriptloaderStr = mwembedresp[scriptloaderIndex:(scriptloaderIndex+130)]
scriptloaderValue = re.split('\'',scriptloaderStr)[2]
scriptloaderValue = scriptloaderValue[0:-8]
if (debug):
	print "[*] Obtained Amazon AWS URL (front) = %s" % (scriptloaderValue)

print "[i] Building download URL ..."
downloadUrl = scriptloaderValue + "mwEmbedFrame.php?&wid=_27017&uiconf_id=8413350&entry_id=" + mediaID + "&flashvars[proxyData]=%7B%22initObj%22%3A%7B%22Locale%22%3A%7B%22LocaleLanguage%22%3A%22%22%2C%22LocaleCountry%22%3A%22%22%2C%22LocaleDevice%22%3A%22%22%2C%22LocaleUserState%22%3A0%7D%2C%22Platform%22%3A0%2C%22SiteGuid%22%3A0%2C%22DomainID%22%3A%220%22%2C%22UDID%22%3A%22%22%2C%22ApiUser%22%3A%22" + apiUserValue + "%22%2C%22ApiPass%22%3A%22" + apiPassValue + "%22%7D%2C%22MediaID%22%3A%22" + mediaID + "%22%2C%22iMediaID%22%3A%22" + mediaID + "%22%2C%22picSize%22%3A%22640X360%22%7D&callback=mwi_SilverlightContainer0"
#print "[i] Built download URL = "
#print "%s" % (downloadUrl)

print "[i] Performing HTTP GET request on download URL ..."
downloadresp = urllib2.urlopen(downloadUrl).read()

if (debug):
	text_file = open("3.downloadresp.txt", "w")
	text_file.write("{}".format(downloadresp))
	text_file.close()

print "[i] Performing JSON parsing ..."
jsonFrom = downloadresp.find("kalturaIframePackageData",3000)
jsonTo = downloadresp.find("isIE8",20000)
jsonextract = downloadresp[(jsonFrom+27):(jsonTo-13)]
jsonextract = jsonextract.decode('string_escape')
jsondata = json.loads(jsonextract)

if (debug):
	text_file = open("4.jsondata.txt", "w")
	text_file.write("{}".format(json.dumps(jsondata,indent=4)))
	text_file.close()
	
print "[i] Obtaining output URLs ..."

try: 
	for x in range(0,10):
		outputurl = jsondata["entryResult"]["meta"]["partnerData"] ["Files"] [x]["URL"].replace("\\","")
		
		if (outputurl.endswith("m3u8") or outputurl.endswith("wvm") or outputurl.endswith("mp4")  ):
		   print outputurl	
except:
	print "Done!"
