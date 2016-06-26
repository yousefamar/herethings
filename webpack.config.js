var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

var entry = {
	'things/index': './src/things/index.ls'
};
require('./config.json').services.forEach(function (service) {
	entry[service + '/create'] = './src/' + service + '/create.ls';
	entry[service + '/result'] = './src/' + service + '/result.ls';
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
		publicPath: '/',
		filename: '[name].min.js'
	},
	module: {
		loaders: [
			{ test: /\.json$/, loader: 'json' },
			{ test: /\.ls$/, loader: 'livescript' },
			{ test: /\.pug$/, loader: 'ignore' },
			//{ test: /\.styl$/, loader: 'style!css!stylus' },
			{ test: /\.styl$/, loader: ExtractTextPlugin.extract('style-loader', 'css-loader?sourceMap!stylus-loader?resolve url') },
			{ test: /\.png$/, loader: 'file?name=res/image/[name].[ext]?[hash]' },
			// FIXME: link rel
			{ test: /\.ico$/, loader: 'file?name=[name].[ext]?[hash]' },
			{ test: /\.wav$/, loader: 'file?name=res/sound/[name].[ext]?[hash]' }
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
	]
};
