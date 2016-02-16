<?php

/**
 * @author Niklas Laxström
 * @license GPL-2.0+
 */
class INaturalistSuggester implements InsertablesSuggester {
	public function getInsertables( $text ) {
		$insertables = array();

		// Variables and html entities
		$matches = array();
		preg_match_all( '/%{[a-z_]+}|&[a-z]+;/', $text, $matches, PREG_SET_ORDER );
		$new = array_map( function( $match ) {
			return new Insertable( $match[0], $match[0] );
		}, $matches );
		$insertables = array_merge( $insertables, $new );

		return $insertables;
	}
}
