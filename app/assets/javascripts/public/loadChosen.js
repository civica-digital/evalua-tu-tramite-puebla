var loadChosen = function(){
    $('.chosen-select').chosen({
       allow_single_deselect: true,
       no_results_text: 'No hay resultados',
       placeholder_text: 'Selecciona una opción',
       width: '100%'
    });
};

var loadChosenlimit = function(){
    $('.chosen-select-limit').chosen({
       allow_single_deselect: true,
       no_results_text: 'No hay resultados',
       placeholder_text: 'Selecciona una opción',
       width: '100%',
       max_selected_options: 2
    });
};

