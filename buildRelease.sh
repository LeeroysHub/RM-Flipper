rm -rf LH*-*-*.tgz LH*-*-*.zip .sconsign.dblite dist build assets/resources/apps assets/resources/nfc/RMProTrainedAmiibo
git pull
./fbt updater_package
DATE_VAR=`date +%m%d`
TIME_VAR=`date +%H%M`
VER_VAR=`cat scripts/version.py | grep "or \"0" | awk -F\" '{print $4}'`
HASH_VAR=`git rev-parse \`git branch -r --sort=committerdate | tail -1\` | awk '{print substr($0,1,7)}' | tail -1`
mv dist/f7-C/f7-update-LEEROY "LH$DATE_VAR-$TIME_VAR"
zip -rq "LH$DATE_VAR-$TIME_VAR-$VER_VAR-$HASH_VAR.zip" "LH$DATE_VAR-$TIME_VAR"
tar -czf "LH$DATE_VAR-$TIME_VAR-$VER_VAR-$HASH_VAR.tgz" "LH$DATE_VAR-$TIME_VAR"
rm -rf assets/dolphin/internal/*
cp -rf .blank_files/dolphinIntBlank/* assets/dolphin/internal/
cp -rf .blank_files/animation_managerBLANK.c applications/services/desktop/animations/animation_manager.c
./fbt updater_package
mv dist/f7-C/f7-update-LEEROY "LH$DATE_VAR-$TIME_VAR-NoAnim"
rm -rf assets/resources/dolphin/*
cp -rf .blank_files/MjK_blank_128x64 assets/resources/dolphin/
cp -rf .blank_files/manifest_None.txt assets/resources/dolphin/manifest_None.txt
cp -rf .blank_files/manifest_None.txt assets/resources/dolphin/manifest.txt
cd assets/resources
tar -cf "../../LH$DATE_VAR-$TIME_VAR-NoAnim/resources.tar" *
cd ../../
zip -rq "LH$DATE_VAR-$TIME_VAR-$VER_VAR-$HASH_VAR-NoAnim.zip" "LH$DATE_VAR-$TIME_VAR-NoAnim"
tar -czf "LH$DATE_VAR-$TIME_VAR-$VER_VAR-$HASH_VAR-NoAnim.tgz" "LH$DATE_VAR-$TIME_VAR-NoAnim"
rm -rf "LH$DATE_VAR-$TIME_VAR"
rm -rf "LH$DATE_VAR-$TIME_VAR-NoAnim"
rm -rf assets/dolphin/internal/*
git stash
echo "BUILD COMPLETED, ZIP AND TGZ GENERATED FOR LH$DATE_VAR-$TIME_VAR-$VER_VAR-$HASH_VAR"
