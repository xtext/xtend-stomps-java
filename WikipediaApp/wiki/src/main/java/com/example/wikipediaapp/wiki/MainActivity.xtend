package com.example.wikipediaapp.wiki

import org.xtendroid.app.AndroidActivity
import org.xtendroid.app.OnCreate
import android.app.ProgressDialog
import java.net.URL
import static org.xtendroid.utils.AsyncBuilder.*
import static extension org.xtendroid.utils.AlertUtils.*
import com.google.common.io.Resources
import com.google.common.base.Charsets

@AndroidActivity(R.layout.activity_main) class MainActivity {

    @OnCreate
    def init() {
        mainLoadQuote.onClickListener = [
            val pd = new ProgressDialog(this)
            pd.message = "Loading Article..."

            async(pd) [
                val data = getData('https://en.wikipedia.org/wiki/Special:Random')
                data.substring(0, Math.min(125, data.length))
            ].then [CharSequence result|
                mainQuote.text = result
            ].onError [Exception error|
                toast("Error: " + error.message)
            ].start()
        ]
    }

    def static String getData(String url) {
        Resources.toString(new URL(url), Charsets.UTF_8)
    }
}
