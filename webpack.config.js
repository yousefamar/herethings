var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
	entry: {
		things: './src/things/index.ls',
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
		new HtmlWebpackPlugin({
			inject: 'body',
			hash: true,
			favicon: 'src/common/favicon.ico',
			title: 'HereThings',
			template: 'src/things/index.jade',
			filename: 'things/index.html'
		}),
		new webpack.optimize.CommonsChunkPlugin('common.min.js'),
		new webpack.optimize.UglifyJsPlugin({
			compress: {
				warnings: false
			},
			sourceMap: true,
			mangle: false
		})
	]
};
