<h1 id="fswc">FSWC</h1>

<p>FreeBSD Website Creator - Host websites on FreeBSD</p>

<p>Downlaod fswc.sh and run it as root as following:</p>

<p>Edit first line - complete the MySQL password <br>
<code>sh fswc.sh</code> - Initial setup which creates nGinx and MySQL servers <br>
<code>sh fswc.sh silviu-s.com</code> for adding a domain (“silviu-s.com”)</p>

<p>nGinx global configuration: <code>/usr/local/etc/nginx/nginx.conf</code> <br>
nGinx logs:</p>

<pre><code>/var/log/nginx/access.log
/var/log/nginx/error.log
</code></pre>

<p>Nginx site configuration file for silviu-s.com is:  <br>
<code>/usr/local/etc/nginx/vhosts/silviu-s.com.conf</code></p>

<p>The HTML folder path for silviu-s.com is:</p>

<pre><code> /var/www/silviu-s.com
</code></pre>

<p>The MySQL master password it will be the password you have completed on first line.</p>
