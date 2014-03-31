This adds a patch to dropbear, that mimic the "ExitOnForwardFailure" of 
OpenSSH. This is the easiest way i've found to implement this, just 2 lines 
of code that close the connection if the forward fails. Without this dropbear
will never returns and will hang for ever.

Signed-off-by: Christian Gagneraud <chris@techworks.ie>
--- /dev/null
+++ b/package/dropbear/patches/600-crude-exit-on-tcp-forward-failure.patch
@@ -0,0 +1,18 @@
+--- a/cli-tcpfwd.c
++++ b/cli-tcpfwd.c
+@@ -79,6 +79,7 @@ void setup_localtcp() {
+ 					fwd->listenport,
+ 					fwd->connectaddr,
+ 					fwd->connectport);
++			dropbear_close("Local TCP forward request failure");
+ 		}		
+ 	}
+ 	TRACE(("leave setup_localtcp"))
+@@ -180,6 +181,7 @@ void cli_recv_msg_request_failure() {
+ 		if (!fwd->have_reply) {
+ 			fwd->have_reply = 1;
+ 			dropbear_log(LOG_WARNING, "Remote TCP forward request failed (port %d -> %s:%d)", fwd->listenport, fwd->connectaddr, fwd->connectport);
++			dropbear_close("Remote TCP forward request failure");
+ 			return;
+ 		}
+ 	}

