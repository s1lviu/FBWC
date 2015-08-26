<h1 id="fswc-femp">FBWC FEMP</h1>

<p><strong>FreeBSD Website Creator - Host websites on FreeBSD without a control panel</strong> <br>
<em>Automatically installs FreeBSD, Nginx, MySQL, and PHP</em></p>

<p>Downlaod fswc.sh and run it as root as following:</p>

<p>Edit first line - complete the MySQL password <br>
<code>sh fswc.sh</code> - Initial setup which creates nGinx and MySQL servers <br>
<code>sh fswc.sh silviu-s.com</code> for adding a domain (“<a href="http://silviu-s.com">silviu-s.com</a>“)</p>

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

<p>This configuration has been succesful tested on a <a href="https://www.digitalocean.com/?refcode=ea14929d1861">DigitalOcean FreeBSD Droplet</a>.</p>
