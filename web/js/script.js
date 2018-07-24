$(document).ready(function () {
    var input, filter, table, tr, td, i;
    table = $(".table_avali");
    tr = $(".table_avali tr");
    $(".userButton").click(function () {
        if ($(".user").is(":visible")) {

            $(".user").slideUp();
        } else {

            $(".livro").hide();
            $(".avaliacao").hide();
            $(".user").slideDown();
            $(".mostra_avali").hide();
        }

    });
    $(".avaliacoesButton").click(function () {
        if ($(".avaliacao").is(":visible")) {
            $(".avaliacao").slideUp();
            $(".mostra_avali").slideUp();

        } else {
            $(".livro").hide();
            $(".user").hide();
            $(".avaliacao").slideDown();
        }

    });
    $(".livrosButton").click(function () {
        if ($(".livro").is(":visible")) {
            $(".livro").slideUp();
        } else {
            $(".user").hide();
            $(".avaliacao").hide();
            $(".livro").slideDown();
            $(".mostra_avali").hide();
        }

    });
    $(".avali_tot").click(function () {
        if ($(".mostra_avali").is(":visible")) {
            $(".mostra_avali").slideUp();
        } else {
            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            }
            $(".mostra_avali").slideDown();

        }

    });


    $(".avali_user").click(function () {
         $(".mostra_avali").slideDown();
        input = $("#iduser option:selected").data('status');
        //filter = input.val();
        filter = $("#iduser option:selected").data('status').toUpperCase();
        for (i = 0; i < tr.length; i++) {

            td = tr[i].getElementsByTagName("td")[1];
            if (td) {
                if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";

                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    });
    $(".avali_livro").click(function () {
        for (i = 0; i < tr.length; i++) {
            tr[i].style.display = "";
        }
        $(".mostra_avali").slideDown();
        
        input = $("#idlivro option:selected").data('status');
        //filter = input.val();
        filter = $("#idlivro option:selected").data('status').toUpperCase();
        
        for (i = 0; i < tr.length; i++) {
          
            td = tr[i].getElementsByTagName("td")[2];
       
                
            if (td) {
                if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";

                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    });


    $(function () {
        $('#example').barrating({
            theme: 'fontawesome-stars'
        });
    });
});