class profile::mwelasticsearch {

  class { 'elasticsearch':
    manage_repo   => true,
    repo_version  => '1.3',
    config        => {
      'script.disable_dynamic' => false,
      'network.bind_host' => "::1",
      # The default sandbox for Groovy is too restrictive for Cirrus.
      # This adds a few more allowed invocations.
      'script.groovy.sandbox.class_whitelist' => [
        # Defaults
        'java.util.Date',
        'java.util.Map',
        'java.util.List',
        'java.util.Set',
        'java.util.ArrayList',
        'java.util.Arrays',
        'java.util.HashMap',
        'java.util.HashSet',
        'java.util.UUID',
        'java.math.BigDecimal',
        'org.joda.time.DateTime',
        'org.joda.time.DateTimeZone',
        'org.elasticsearch.common.joda.time.DateTime',
        'org.elasticsearch.common.joda.time.DateTimeZone',
        # Added for Cirrus
        'java.util.Locale',
        'org.apache.lucene.util.automaton.RegExp',
        'org.apache.lucene.util.automaton.CharacterRunAutomaton',
         # Added for Translate
        'org.apache.lucene.search.spell.LevensteinDistance',
      ],
      'script.groovy.sandbox.package_whitelist' => [
        # Defaults
        'java.util',
        'java.lang',
        'org.joda.time',
        'org.elasticsearch.common.joda.time',
        # Added for Cirrus
        'org.apache.lucene.util.automaton',
        # Added for Translate
        'org.apache.lucene.search.spell',
      ],
      'script.groovy.sandbox.receiver_whitelist' => [
      # Defaults
        'java.lang.Math',
        'java.lang.Integer',
        '"[I"',
        '"[[I"',
        '"[[[I"',
        'java.lang.Float',
        '"[F"',
        '"[[F"',
        '"[[[F"',
        'java.lang.Double',
        '"[D"',
        '"[[D"',
        '"[[[D"',
        'java.lang.Long',
        '"[J"',
        '"[[J"',
        '"[[[J"',
        'java.lang.Short',
        '"[S"',
        '"[[S"',
        '"[[[S"',
        'java.lang.Character',
        '"[C"',
        '"[[C"',
        '"[[[C"',
        'java.lang.Byte',
        '"[B"',
        '"[[B"',
        '"[[[B"',
        'java.lang.Boolean',
        '"[Z"',
        '"[[Z"',
        '"[[[Z"',
        'java.math.BigDecimal',
        'java.util.Arrays',
        'java.util.Date',
        'java.util.List',
        'java.util.Map',
        'java.util.Set',
        'java.lang.Object',
        'org.joda.time.DateTime',
        'org.joda.time.DateTimeUtils',
        'org.joda.time.DateTimeZone',
        'org.joda.time.Instant',
        'org.elasticsearch.common.joda.time.DateTime',
        'org.elasticsearch.common.joda.time.DateTimeUtils',
        'org.elasticsearch.common.joda.time.DateTimeZone',
        'org.elasticsearch.common.joda.time.Instant',
        # Added for Cirrus
        'org.apache.lucene.util.automaton.RegExp',
        'org.apache.lucene.util.automaton.CharacterRunAutomaton',
        # Added for Translate
        'org.apache.lucene.search.spell.LevensteinDistance',
      ]
    },
    java_install  => true,
    init_defaults => {
        'ES_HEAP_SIZE' => '3g',
    },
  }

  elasticsearch::plugin { 'mobz/elasticsearch-head':
    module_dir => 'head'
  }
}