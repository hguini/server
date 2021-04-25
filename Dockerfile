# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hguini <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/09 19:10:05 by hguini            #+#    #+#              #
#    Updated: 2021/03/04 14:58:57 by hguini           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y		\
	nginx					\
	vim						\
	openssl					\
	default-mysql-server	\
	wget					\
	php7.3-fpm				\
	php7.3-mysql						

COPY /srcs/default /etc/nginx/sites-available
COPY /srcs/scripts.sh .


# Установка WordPress

WORKDIR /var/www/html
RUN wget https://ru.wordpress.org/latest-ru_RU.tar.gz
RUN tar -xvf latest-ru_RU.tar.gz
RUN rm -rf latest-ru_RU.tar.gz
COPY /srcs/wp-config.php /var/www/html/wordpress

# Установка PHPmyAdmin

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages phpmyadmin

RUN chown -R www-data:www-data . 
RUN chmod -R 755 .

WORKDIR /

CMD bash scripts.sh

