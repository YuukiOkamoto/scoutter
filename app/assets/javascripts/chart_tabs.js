$('#graph_tabs a').on('click', function (event) {
  const tab_id = $(event.target).attr('id');
  graph_ajax(tab_id);
  toggle_active(tab_id);
  return false;
});

function graph_ajax(tab_id) {
  $.ajax({
    url: '/users/101',
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
        lineTension: 0.3,
        pointRadius: 0,
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
