package ca.qc.cstj.consortium.core

import android.widget.TextView
import com.google.android.material.slider.Slider
import com.google.android.material.textfield.TextInputLayout
import java.math.BigDecimal
import java.math.RoundingMode
import kotlin.random.Random

//Toutes ces méthodes d'extensions sont pour alléger le code
var TextInputLayout.textToString
    get() = editText!!.text.toString()
    set(value) = editText!!.setText(value)

fun textToFloat(textView: TextView): Float {
    return BigDecimal(textView.text.toString().toDouble()).setScale(2, RoundingMode.HALF_EVEN).toFloat()
}

fun randomFloatValue(): Float {
    return BigDecimal((Random.nextFloat() * (200.00f - 50.00f) + 50.00f).toString().toDouble()).setScale(2, RoundingMode.HALF_EVEN).toFloat()
}

fun addRandomFloatValueToText(textView: TextView): Float {
    return BigDecimal((textToFloat(textView) + randomFloatValue()).toString().toDouble()).setScale(2, RoundingMode.HALF_EVEN).toFloat()
}

fun sliderDoubleDecimalToFloat(slider: Slider): Float {
    return BigDecimal(floatToDoubleDecimal(slider.value).toString().toDouble()).setScale(2, RoundingMode.HALF_EVEN).toFloat()
}

fun sliderDoubleDecimalToString(slider: Slider): String {
    return BigDecimal(floatToDoubleDecimal(slider.value).toString().toDouble()).setScale(2, RoundingMode.HALF_EVEN).toString()
}

fun floatToDoubleDecimal(value: Float) : Float {
    return BigDecimal(value.toString().toDouble()).setScale(2, RoundingMode.HALF_EVEN).toFloat()
}