

function DisplayBasicLineChart(chartid, title, yAxisLabel, xAxisLabel, labels, datasets, charttype) {
    var config = {
        type: charttype,
        data: {
            labels: labels,
            datasets: datasets
        },
        options: {
            title: {
                display: true,
                text: title,
                position: 'top',
                fontStyle: 'bold',
                fontSize: 15,
                fontFamily: 'Nunito'
            },
            scales: {
                yAxes: [{
                    ticks: {
                        suggestedMin: chartid.includes("Sound") ? 60 : chartid.includes("Temperature") ? 20 : 0,
                        suggestedMax: chartid.includes("Sound") ? 76 : chartid.includes("Temperature") ? 30 : 1
                    },
                    scaleLabel: {
                        display: true,
                        labelString: yAxisLabel,
                        fontStyle: 'bold',
                        fontSize: 15,
                        fontFamily: 'Nunito'
                    }
                }],
                xAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: xAxisLabel,
                        fontStyle: 'bold',
                        fontSize: 15,
                        fontFamily: 'Nunito'
                    }
                }]
            },
            plugins: {
                colorschemes: {
                    scheme: 'tableau.ClassicCyclic13'
                }
            }
        }
    };

    var newChart = new Chart(
        document.getElementById(chartid),
        config
    );
}