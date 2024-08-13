echo "start updating"
./scripts/feeds update -a

echo "start installing"
./scripts/feeds install -a
exit 0
