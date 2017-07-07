---
title: "Contactar"
comments: false
---
<form class="pure-form" method="POST" action="http://formspree.io/alvaro@alvr.me">
    <fieldset class="pure-group">
        <input type="text" name="name" class="pure-input-1" placeholder="Name" required>
        <input type="email" name="email" class="pure-input-1" placeholder="Email" required>
    </fieldset>

    <fieldset class="pure-group">
    	<input type="text" name="_subject" class="pure-input-1" placeholder="Subject">
        <textarea name="message" class="pure-input-1" placeholder="Your message" required></textarea>
    </fieldset>

    <input type="hidden" name="_next" value="/" />
    <input type="hidden" name="_language" value="es" />
	<input type="text" name="_gotcha" style="display:none" />
    <button type="submit" class="pure-button pure-input-1 pure-button-primary">Send</button>
</form>