This project is a demo for Nginx&OpenResty

start: $ nginx -p `pwd`/ -c conf/nginx.conf
reload: $ nginx -s reload
stop: $ nginx -s stop

1. basic: nginx_basic.conf, $curl localhost:8080
2. load-balance: nginx_reverse_proxy.conf, $curl localhost:80
3. import custom lib: nginx_sum.conf, $curl 'localhost:8080/add?a=8&b=3'    
4. redirect: nginx_redirect.conf, http://www.test.com:8080/entry?userid=120 in browser 
5. local cache: nginx_cache.conf, $curl 'localhost:8080/cache?id=123'    
6. redis: nginx_redis.conf, $curl 'localhost:8080/redis?cmd=get&key=a'      
7. mysql: nginx_mysql.conf, $curl 'localhost:8080/mysql'      

   

  
