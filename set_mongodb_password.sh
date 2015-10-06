RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating an admin user in MongoDB"
mongo admin --eval "db.createUser({user: 'admin', pwd: '$PWD_ROOT', roles:['root']});"
mongo admin -u admin -p $PWD_ROOT --eval "db.getSiblingDB('sdg').createUser({user: 'sdg', pwd: '$PWD_SDG', roles:['readWrite']});"
mongo admin -u admin -p $PWD_ROOT --eval "db.getSiblingDB('sdgtest').createUser({user: 'sdg', pwd: '$PWD_SDG', roles:['readWrite']});"
mongo admin -u admin -p $PWD_ROOT --eval "db.getSiblingDB('sdgtlc').createUser({user: 'sdg', pwd: '$PWD_SDG', roles:['readWrite']});"
mongo admin -u admin -p $PWD_ROOT --eval "db.getSiblingDB('sdgtlctest').createUser({user: 'sdg', pwd: '$PWD_SDG', roles:['readWrite']});"

echo "=> Done!"
touch /data/db/.mongodb_password_set

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo sdgtlctest -u sdg -p 1234 --host <host> --port <port>"
echo ""
echo "========================================================================"
