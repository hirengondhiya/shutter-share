function hook_up_calc_function(){
    if (typeof moment != "undefined")
    {
        $('#start_date, #end_date').change(function(){
            start_date = moment($('#start_date')[0].value)
            end_date = moment($('#end_date')[0].value)
            rate = parseInt($('#rate')[0].value.replace("$","").replace(" per day",""))
            if (start_date._isValid && end_date._isValid && start_date.isAfter() && end_date.isAfter() && end_date.isAfter(start_date)) {
                duration = end_date.diff(start_date, 'days')
                $('#duration')[0].value = duration + " Days"                
                amount = rate * duration
                $('#total_amount')[0].value = "$" + amount
            } else {
                $('#duration')[0].value = "X Days"
                $('#total_amount')[0].value = "$ amount"
            }
        })    
    } else {
        setTimeout(hook_up_calc_function, 100);
    }
}
$(document).ready(function(){
    hook_up_calc_function()
})