name="webapi-noneservice-tests"
version=$(grep main-version ../../VERSION |awk -F \" '{print $4}')
sub_version=$(grep release-version ../../VERSION |awk -F \" '{print $4}')
appname=$(echo $name|sed 's/-/_/g')

LIST=`find $(dirname $0)/../../../crosswalk-test-suite/webapi/ -maxdepth 1 -type d |awk '/-tests$/'`

BLACK="webapi-style-css3-tests
webapi-ambientlight-w3c-tests
webapi-imports-w3c-tests
webapi-htmltemplates-html5-tests
webapi-runtime-xwalk-tests
webapi-shadowdom-w3c-tests
ivi-tests
webapi-dlna-xwalk-tests
tizen-tests
tct-wgtapi
tct-widget
tct-manual-w3c-tests
tct-canvas-html5-tests
tct-cors-w3c-tests
tct-csp-w3c-tests
tct-navigationtiming-w3c-tests
tct-sandbox-html5-tests
tct-sessionhistory-html5-tests
tct-sse-w3c-tests
tct-webmessaging-w3c-tests
tct-websocket-w3c-tests
tct-xmlhttprequest-w3c-tests
webapi-webspeech-w3c-tests
webapi-resourcetiming-w3c-tests"

for list in $LIST;do
    suite_name=`echo $list |awk -F "/" '{print $NF}'`
    grep \<testcase $list/tests.xml > /dev/null 2>&1
    if [ $? -eq 1 ];then
        LIST=`echo "$LIST" | sed "/$suite_name/d"`
    fi
done

for black in $BLACK;do
    LIST=`echo "$LIST" | sed "/$black/d"`
done
