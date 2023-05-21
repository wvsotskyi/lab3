@echo off
chcp 65001

mkdir Лабораторные\ПЗ-22-3\"Висоцкий А. О."\batch
cd Лабораторные\ПЗ-22-3\"Висоцкий А. О."\batch
mkdir "Скрытая папка" "Не скрытая папка"
attrib +h "Скрытая папка"
xcopy /? > "Не скрытая папка"\copyhelp.txt
echo F | xcopy "Не скрытая папка"\copyhelp.txt "Скрытая папка"\copied_copyhelp.txt