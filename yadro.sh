#!/bin/bash
function log_error() {
while IFS='' read -r line
do echo "$(date) $line" >> ~/err_journal.txt
done
}

touch ~/err_journal.txt
while true ;do
    echo "=========================================="
	echo "1. Создать каталог"
	echo "2. Сменить текущий каталог"
	echo "3. Напечатать содержимое текущего каталога"
	echo "4. Создать файл"
	echo "5. Удалить файл"
	echo "6. Выйти из программы"
	echo "=========================================="
	read choice
	case $choice in
		1)
		echo "Вы находитесь в каталоге `pwd`"
		echo "Введите абсолютный путь для создания каталога:"
		read name_dir
		if [ ! -d $name_dir ]; then
			mkdir $name_dir 2> >(log_error)
			if [ $? == 0 ]; then
				echo "Каталог $name_dir создан!"
			else
				echo "Произошла ошибка! Смотрите журнал ~/err_journal.txt"
			fi
		else
			echo "Каталог с таким названием уже существует!"
		fi
		;;
		2)
		echo "Вы находитесь в каталоге `pwd`"
		echo "Укажите путь, по которому необходимо перейти:"
		read chdi
		cd $chdi 2> >(log_error)
		if [ $? == 0 ]; then
			echo "Вы находитесь в каталоге `pwd`"
		else
			echo "Произошла ошибка! Смотрите журнал ~/err_journal.txt"
		fi
		;;
		3)
		echo "Вы находитесь в каталоге `pwd`. Содержимое каталога:"
		ls -l
		;;
		4)
		echo "Вы находитесь в каталоге `pwd`"
		echo "Введите название файла:"
		read name_file
		if [ ! -f $name_file ]; then
			touch $name_file 2> >(log_error)
			if [ $? == 0 ]; then
				echo "Файл $name_file создан!"
			else
				echo "Произошла ошибка! Смотрите журнал ~/err_journal.txt"
			fi
		else
			echo "Файл с таким названием уже существует!"
		fi
		;;
		5)
		echo "Вы находитесь в каталоге `pwd`. Содержимое каталога:"
		ls -l
		echo "Введите название файла, который необходимо удалить:"
		read name_file
		if [ ! -f $name_file ]; then
			echo "Файл с таким названием отсутствует!"
		else
			echo "Вы дествительно хотите удалить файл $name_file? [y\n]"
			while true; do
				read var
				if [ $var == "y" ]; then
					rm -f $name_file 2> >(log_error)
					if [ $? == 0 ]; then
						echo "Файл $name_file удален!"
						break
					else
						echo "Произошла ошибка! Смотрите журнал ~/err_journal.txt"
						break
					fi
				elif [ $var == "n" ]; then
					echo "Файл $name_file не удален!"
					break
				else
					echo "Введена неверная команда! Попробуйте еще раз."
				fi
			done
		fi
		;;
		6)
		exit 0
		;;
		*)
		echo "Такого пункта в меню нет! Попробуйте еще раз."
		;;
	esac
done
exit 0