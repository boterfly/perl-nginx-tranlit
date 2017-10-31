#######Add to nginx.conf############

load_module /usr/lib/nginx/modules/ngx_http_perl_module.so;

http {
        perl_require /usr/local/share/perl/5.18.2/Lingua/Translit.pm;
        perl_require /usr/share/perl/5.18.2/utf8.pm;
        perl_require /usr/share/perl/5.18.2/open.pm;
        perl_require /etc/nginx/conf/trans-nginx.pl; 
}
######Add your_site.conf############
        location ~* /.*(([а-я])|[\s+]) {
        rewrite ^/(.*)/$ /$1 permanent;
        perl transnginx::handler;
        }
