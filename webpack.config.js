var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

function buildPage(service) {
	return {
		inject: 'body',
		chunks: ['common', service],
		hash: true,
		favicon: 'src/common/favicon.ico',
		template: 'src/' + service + '/index.jade',
		filename: service + '/index.html'
	}
}

module.exports = {
	entry: {
		things: './src/things/index.ls',
		sketch: './src/sketch/index.ls',
	},
	resolve: {
		root: __dirname + '/src'
	},
	output: {
		path: __dirname + '/build',
		filename: '[name]/[name].min.js'
	},
	module: {
		loaders: [
			{ test: /\.ls$/, loader: 'livescript' },
			{ test: /\.jade$/, loader: 'jade' },
			//{ test: /\.styl$/, loader: 'style!css!stylus' },
			{ test: /\.styl$/, loader: ExtractTextPlugin.extract('style-loader', 'css-loader?sourceMap!stylus-loader?resolve url') },
			{ test: /\.png$/, loader: 'file?name=image/[name]-[hash].[ext]' }
		]
	},
	debug: true,
	devtool: 'source-map',
	plugins: [
		new ExtractTextPlugin('[name].min.css'),
		new HtmlWebpackPlugin(buildPage('things')),
		new HtmlWebpackPlugin(buildPage('sketch')),
		//new webpack.optimize.CommonsChunkPlugin('common.min.js'),
		new webpack.optimize.UglifyJsPlugin({
			compress: {
				warnings: false
			},
			sourceMap: true,
			mangle: false
		})
	]
};
