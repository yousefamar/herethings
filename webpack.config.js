var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

var services = require('./config.json').services;

var entry = {};
var pages = [];

services.map(function (service) {
	entry[service] = './src/' + service + '/index.ls';
	pages.push(new HtmlWebpackPlugin({
		inject: 'body',
		chunks: ['common', service],
		hash: true,
		favicon: 'src/common/favicon.ico',
		template: 'src/' + service + '/index.jade',
		filename: service + '/index.html'
	}));
});

module.exports = {
	entry: entry,
	resolve: {
		root: __dirname + '/src',
		alias: {
			config: __dirname + '/config.json'
		}
	},
	output: {
		path: __dirname + '/build',
		filename: '[name]/[name].min.js'
	},
	module: {
		loaders: [
			{ test: /\.json$/, loader: 'json' },
			{ test: /\.ls$/, loader: 'livescript' },
			{ test: /\.jade$/, loader: 'jade' },
			//{ test: /\.styl$/, loader: 'style!css!stylus' },
			{ test: /\.styl$/, loader: ExtractTextPlugin.extract('style-loader', 'css-loader?sourceMap!stylus-loader?resolve url') },
			{ test: /\.png$/, loader: 'file?name=image/[name].[ext]?[hash]' },
			{ test: /\.wav$/, loader: 'file?name=sound/[name].[ext]?[hash]' }
		]
	},
	externals: {
		jquery: "jQuery"
	},
	//debug: true,
	//devtool: 'source-map',
	plugins: [
		new ExtractTextPlugin('[name].min.css'),
		//new webpack.optimize.CommonsChunkPlugin('common.min.js'),
		new webpack.optimize.UglifyJsPlugin({
			compress: {
				warnings: false
			},
			//sourceMap: true,
			mangle: false
		})
	].concat(pages)
};
