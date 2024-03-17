#!bin/bash

#справка
give_info()
{
    echo "Here are the script for HTML to provide an info about your OS. Enjoy^^"  
}

#функция для вывода информации о хосте
get_host_info()
{
    echo "<h2>Info about host:</h2>"
    echo "<p>Host name: $(hostname)</p>" #имя хоста
    echo "<p>IP-adress: $(hostname -I)</p>" #поиск IP
}

get_os_info()
{
    echo "<h2>Info about OS charasterics:</h2>"
    echo "<p>Distributive name: $(lsb_release -d | cut -f2)</p>" #вывод только описания дистрибутива
    echo "<p>Version: $(uname -r)</p>" #версия ядра, -a для полной инфы о ядре
}

get_processor_info()
{
    echo "<h2>Info about processor:</h2>"
    echo "<p>Processor model: $(cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2 )</p>" 
    #выводим инфу о каждом процессоре, затем выводим только строчки формата model_name: ..., фильтруем повторяющиеся строки, оставляем второе поле (разделенной двоеточием) иии вот 
    echo "<p>Number of processor cores: $(cat /proc/cpuinfo | grep 'processor' | wc -l)</p>" 
    #выводим инфу о каждом процессоре, затем выводим только строчки формата processor: n, а затем считаем количество lines
}

get_users_info() 
{
    echo "<h2>List of users and groups:</h2>"
    echo "<table border='1'>"
    echo "<tr><th>User</th><th>Groups</th></tr>"
        while IFS=: read -r user _ uid gid _ home shell; do
            groups=$(groups $user | cut -d' ' -f4-)
            echo "<tr><td>$user</td><td>$groups</td></tr>"
        done < /etc/passwd
    echo "</table>"
}

generate_html_page()
{
    give_info
    echo "<!DOCTYPE html>"
    echo "<html>"
    echo "<head>"
    echo "<title>work №1-30</title>"
    echo "</head>"
    echo "<body>"
    get_host_info
    get_os_info
    get_processor_info
    get_users_info
    echo "</body>"
    echo "</html>"
}

if [ "$#" -ne 0 ]; then #проверяем количество переданных аргументов
    echo "Данные не получены, что-то пошло не так"
    exit 1
fi

generate_html_page
exit 0
