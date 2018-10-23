(function () {
  $(window).ready(function(){
    const tab_id = $('#graph_tabs .tab--active').attr('id');
    const user_id = jQuery("#lineChartCanvas").data('user_id');
    graphAjax(tab_id, user_id);
  });

  $('#graph_tabs .ajax-link').on('click', function (event) {
    const tab_id = $(event.target).attr('id');
    const user_id = jQuery("#lineChartCanvas").data('user_id');
    graphAjax(tab_id, user_id);
    toggle_active(tab_id);
    event.preventDefault();
  });

  function graphAjax(tab_id, user_id) {
    $.ajax({
      url: `/users/${user_id}`,
      type: 'GET',
      dataType: 'json',
      data: {
        'period': tab_id
      }
    }).done(function (data) {
      render_graph(data);
    });
  }

  function toggle_active(tab_id) {
    $("#graph_tabs *").removeClass("tab--active");
    $(`#${tab_id}`).addClass("tab--active");
  }

  let chart = null

  function render_graph(data) {
    if(chart){
      chart.destroy();
    }
    chart = new Chart(document.getElementById("lineChartCanvas"), {
      type: "line",
      data: {
        labels: data.labels,
        datasets: [{
          label: "Twitter戦闘力",
          data: data.data,
          borderColor: "rgb(75, 192, 192)",
          borderWidth: 2,
          lineTension: 0.3,
          pointRadius: 1,
          pointHitRadius: 10,
          spanGaps: true
        }]
      },
      options: {
        legend: {
          labels: {
            fontColor: 'darkgray'
          }
        },
        scales: {
          yAxes: [{
            ticks: {
              fontColor: "darkgray"
            }
          }],
          xAxes: [{
            ticks: {
              fontColor: "darkgray"
            }
          }]
        }
      }
    });
  }
}());
