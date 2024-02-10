import Chart from 'chart.js/auto';

const labels = ['NorthAmerica', 'Antarctica', 'Asia', 'Oceania', 'Europe', 'Africa', 'SouthAmerica', 'Unknown']
const data = {
    labels: labels,
    datasets: [{
        label: 'Access Region',
        data: [0, 0, 0, 0, 0, 0, 0],
        backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(255, 159, 64, 0.2)',
            'rgba(255, 205, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(201, 203, 207, 0.2)'
        ],
        borderColor: [
            'rgb(255, 99, 132)',
            'rgb(255, 159, 64)',
            'rgb(255, 205, 86)',
            'rgb(75, 192, 192)',
            'rgb(54, 162, 235)',
            'rgb(153, 102, 255)',
            'rgb(201, 203, 207)'
        ],
        borderWidth: 1
    }]
};

const config = {
    type: 'bar',
    data: data,
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    },
};

let hooks = {}
hooks.chart = {
    mounted() {
        var ctx = this.el
        var chart = new Chart(ctx, config)
        this.handleEvent("points", ({ points }) => {
            chart.data.datasets[0].data = points
            chart.update()
        })
    }
}

export default hooks
